#version 460 core

precision highp float;

#include <flutter/runtime_effect.glsl>

uniform vec2 uPixels;
uniform vec2 uSize;
uniform sampler2D uTexture;

out vec4 fragColor;

void main() {
  vec2 uv = FlutterFragCoord().xy / uSize;
  if (uPixels.x >= uSize.x && uPixels.y >= uSize.y) {
    fragColor = texture(uTexture, uv);
    return;
  }
  vec2 puv = round(uv * uPixels) / uPixels;
  fragColor = texture(uTexture, puv);
}