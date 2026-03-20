from PIL import Image, ImageDraw

size = 1024
scale = size / 128.0


def s(v: float) -> float:
    return v * scale


img = Image.new("RGBA", (size, size), (0, 0, 0, 0))
draw = ImageDraw.Draw(img, "RGBA")

draw.rounded_rectangle(
    [(0, 0), (size - 1, size - 1)],
    radius=int(s(36)),
    fill=(255, 211, 90, 255),
)


def cubic(p0, p1, p2, p3, t):
    mt = 1 - t
    x = (mt**3) * p0[0] + 3 * (mt**2) * t * p1[0] + 3 * mt * (t**2) * p2[0] + (t**3) * p3[0]
    y = (mt**3) * p0[1] + 3 * (mt**2) * t * p1[1] + 3 * mt * (t**2) * p2[1] + (t**3) * p3[1]
    return x, y


segments = [
    ((64, 92), (46, 79), (34, 68), (34, 54)),
    ((34, 54), (34, 44), (42, 36), (52, 36)),
    ((52, 36), (58, 36), (62, 39), (64, 43)),
    ((64, 43), (66, 39), (70, 36), (76, 36)),
    ((76, 36), (86, 36), (94, 44), (94, 54)),
    ((94, 54), (94, 68), (82, 79), (64, 92)),
]

points = []
for seg in segments:
    for i in range(60):
        t = i / 59.0
        x, y = cubic(*seg, t)
        points.append((s(x), s(y)))

draw.polygon(points, fill=(18, 17, 11, int(0.42 * 255)))

out_path = "assets/icons/locket_logo.png"
img.save(out_path, "PNG")
print(f"Generated: {out_path}")

