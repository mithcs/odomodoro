package odomodoro

import "vendor:raylib"

BACKGROUND    :: raylib.RED
DURATION      :: 20 // seconds
TARGET_FPS    :: 1

main :: proc() {
    input: [1]byte

    line: cstring

    screen_width := raylib.GetScreenWidth()
    screen_height := raylib.GetScreenHeight()

    raylib.SetConfigFlags({.WINDOW_TOPMOST})
    raylib.InitWindow(screen_width, screen_height, "odomodoro")
    defer raylib.CloseWindow()

    raylib.SetTargetFPS(TARGET_FPS)

    center_width := raylib.GetScreenWidth() / 2;
    center_height := raylib.GetScreenHeight() / 2;

    for !raylib.WindowShouldClose() {
        if (raylib.IsKeyDown(raylib.KeyboardKey.ENTER) || raylib.GetTime() >= DURATION) {
            break
        }

        raylib.BeginDrawing()

        raylib.ClearBackground(BACKGROUND)

        line = cstring("Take a break!")
        length := raylib.MeasureText(line, 40)
        raylib.DrawText(line, center_width - length / 2, center_height - 60, 40, raylib.DARKBLUE)

        line = cstring("Do some stretching!")
        length = raylib.MeasureText(line, 40)
        raylib.DrawText(line, center_width - length / 2, center_height - 20, 40, raylib.DARKBLUE)

        line = cstring("And a sip of water always helps")
        length = raylib.MeasureText(line, 40)
        raylib.DrawText(line, center_width - length / 2, center_height + 20, 40, raylib.DARKBLUE)

        raylib.EndDrawing()
    }
}
