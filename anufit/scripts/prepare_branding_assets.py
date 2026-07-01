#!/usr/bin/env python3
"""Prepare launcher foreground and notification icons from app_logo.png."""

from __future__ import annotations

from collections import deque
from pathlib import Path

from PIL import Image

ROOT = Path(__file__).resolve().parents[1]
SRC = ROOT / "assets/images/app_logo.png"
FOREGROUND_OUT = ROOT / "assets/images/app_icon_foreground.png"
NOTIFICATION_OUT = ROOT / "assets/images/ic_notification.png"
RES_ROOT = ROOT / "android/app/src/main/res"

BRAND_GREEN = (9, 170, 108)
GREEN_TOLERANCE = 55


def _is_brand_green(r: int, g: int, b: int) -> bool:
    return (
        abs(r - BRAND_GREEN[0]) <= GREEN_TOLERANCE
        and abs(g - BRAND_GREEN[1]) <= GREEN_TOLERANCE
        and abs(b - BRAND_GREEN[2]) <= GREEN_TOLERANCE
    )


def _flood_fill_background(rgba: Image.Image) -> Image.Image:
    """Remove the outer green fill using flood fill from image edges."""
    pixels = rgba.load()
    width, height = rgba.size
    visited = [[False] * width for _ in range(height)]
    queue: deque[tuple[int, int]] = deque()

    def try_seed(x: int, y: int) -> None:
        if x < 0 or y < 0 or x >= width or y >= height or visited[y][x]:
            return
        r, g, b, a = pixels[x, y]
        if a < 32 or not _is_brand_green(r, g, b):
            return
        visited[y][x] = True
        queue.append((x, y))

    for x in range(width):
        try_seed(x, 0)
        try_seed(x, height - 1)
    for y in range(height):
        try_seed(0, y)
        try_seed(width - 1, y)

    while queue:
        x, y = queue.popleft()
        pixels[x, y] = (0, 0, 0, 0)
        for nx, ny in ((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)):
            if 0 <= nx < width and 0 <= ny < height and not visited[ny][nx]:
                r, g, b, a = pixels[nx, ny]
                if a >= 32 and _is_brand_green(r, g, b):
                    visited[ny][nx] = True
                    queue.append((nx, ny))

    return rgba


def _luma(r: int, g: int, b: int) -> float:
    return 0.299 * r + 0.587 * g + 0.114 * b


def _is_footprint_pixel(r: int, g: int, b: int) -> bool:
    """Dark interior mark (footprint), not the colored progress ring."""
    return _luma(r, g, b) < 95 and g < 140 and b < 120


def make_foreground(src: Image.Image) -> Image.Image:
    rgba = _flood_fill_background(src.convert("RGBA"))
    pixels = rgba.load()
    width, height = rgba.size
    for y in range(height):
        for x in range(width):
            r, g, b, a = pixels[x, y]
            if a < 32:
                continue
            if _is_brand_green(r, g, b):
                pixels[x, y] = (0, 0, 0, 0)
            elif _is_footprint_pixel(r, g, b):
                pixels[x, y] = (255, 255, 255, 255)
    return rgba


def make_notification_icon(src: Image.Image, size: int = 96) -> Image.Image:
    """White silhouette (ring + mark) for Android notification small icon."""
    foreground = make_foreground(src)
    bbox = foreground.getbbox()
    if bbox is None:
        out = Image.new("RGBA", (size, size), (0, 0, 0, 0))
        px = out.load()
        cx, cy, r = size // 2, size // 2, max(2, size // 6)
        for y in range(size):
            for x in range(size):
                if (x - cx) ** 2 + (y - cy) ** 2 <= r ** 2:
                    px[x, y] = (255, 255, 255, 255)
        return out

    cropped = foreground.crop(bbox)
    side = max(cropped.size)
    square = Image.new("RGBA", (side, side), (0, 0, 0, 0))
    square.paste(cropped, ((side - cropped.size[0]) // 2, (side - cropped.size[1]) // 2))

    inset = int(size * 0.15)
    target = max(1, size - inset * 2)
    square = square.resize((target, target), Image.Resampling.LANCZOS)

    rgba = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    rgba.paste(square, (inset, inset), square)
    px = rgba.load()
    for y in range(size):
        for x in range(size):
            if px[x, y][3] > 48:
                px[x, y] = (255, 255, 255, 255)
            else:
                px[x, y] = (255, 255, 255, 0)
    return rgba


def make_notification_icons(src: Image.Image) -> None:
    sizes = {
        "drawable-mdpi": 24,
        "drawable-hdpi": 36,
        "drawable-xhdpi": 48,
        "drawable-xxhdpi": 72,
        "drawable-xxxhdpi": 96,
    }
    for folder, px in sizes.items():
        target_dir = RES_ROOT / folder
        target_dir.mkdir(parents=True, exist_ok=True)
        make_notification_icon(src, size=px).save(target_dir / "ic_notification.png")

    default_dir = RES_ROOT / "drawable"
    default_dir.mkdir(parents=True, exist_ok=True)
    make_notification_icon(src, size=48).save(default_dir / "ic_notification.png")


def flatten_splash_assets() -> None:
    """Bake brand-green behind splash images so Android does not render alpha as black."""
    patterns = ("splash.png", "android12splash.png")
    for folder in RES_ROOT.iterdir():
        if not folder.is_dir() or not folder.name.startswith("drawable"):
            continue
        for name in patterns:
            path = folder / name
            if not path.exists():
                continue
            img = Image.open(path).convert("RGBA")
            flat = Image.new("RGBA", img.size, BRAND_GREEN + (255,))
            flat.alpha_composite(img)
            flat.convert("RGB").save(path)


def main() -> None:
    if not SRC.exists():
        raise SystemExit(f"Missing source logo: {SRC}")

    src = Image.open(SRC)
    foreground = make_foreground(src)
    foreground.save(FOREGROUND_OUT)

    notification = make_notification_icon(src)
    notification.save(NOTIFICATION_OUT)
    make_notification_icons(src)

    print(f"Wrote {FOREGROUND_OUT.relative_to(ROOT)}")
    print(f"Wrote {NOTIFICATION_OUT.relative_to(ROOT)}")
    print("Wrote Android drawable-*/ic_notification.png")


if __name__ == "__main__":
    import sys

    if len(sys.argv) > 1 and sys.argv[1] == "--flatten-splash":
        flatten_splash_assets()
        print("Flattened splash/android12splash onto brand green background.")
    else:
        main()
