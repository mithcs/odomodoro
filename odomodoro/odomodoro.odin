package odomodoro

import "vendor:raylib"

SCREEN_WIDTH  :: 1280
SCREEN_HEIGHT :: 720
TARGET_FPS    :: 60

main :: proc() {
    input: [1]byte

    line: cstring

    raylib.SetConfigFlags({.WINDOW_MAXIMIZED})

    raylib.InitWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "odomodoro")
    defer raylib.CloseWindow()

    raylib.SetTargetFPS(TARGET_FPS)

    for !raylib.WindowShouldClose() {
        if (raylib.IsKeyDown(raylib.KeyboardKey.ENTER)) {
            break
        }

        raylib.BeginDrawing()

        raylib.ClearBackground(raylib.GREEN)

        line = cstring("Take a break!")
        length := raylib.MeasureText(line, 40)
        raylib.DrawText(line, SCREEN_WIDTH / 2 - length / 2, SCREEN_HEIGHT / 2 - 60, 40, raylib.DARKBLUE)

        line = cstring("Do some stretching!")
        length = raylib.MeasureText(line, 40)
        raylib.DrawText(line, SCREEN_WIDTH / 2 - length / 2, SCREEN_HEIGHT / 2 - 20, 40, raylib.DARKBLUE)

        line = cstring("And a sip of water always helps")
        length = raylib.MeasureText(line, 40)
        raylib.DrawText(line, SCREEN_WIDTH / 2 - length / 2, SCREEN_HEIGHT / 2 + 20, 40, raylib.DARKBLUE)

        raylib.EndDrawing()
    }
}
