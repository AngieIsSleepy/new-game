shader_type canvas_item;

uniform float speed_x = -10.0;
uniform float speed_y = 10.0;   

void fragment() {
    vec2 uv_shift = UV + vec2(TIME * speed_x / 1000.0, TIME * speed_y / 500.0);
    COLOR = texture(TEXTURE, uv_shift);
}

