shader_type canvas_item;


uniform sampler2D SCREEN_TEXTURE : hint_screen_texture,filter_nearest,repeat_disable;
uniform sampler2D LUT : source_color, filter_nearest_mipmap;

void fragment() {
	vec3 color = texture(SCREEN_TEXTURE,UV).rgb ;
	float cell_count = 8.0;
	float color_number = 64.0;

	vec3 index = clamp(color * color_number, 0.0, color_number-1.0);
	vec2 blue_index = mod(floor(index.b / vec2(1.0,cell_count)),cell_count);
	vec2 lut_uvs = (index.rg / color_number + blue_index)/ cell_count;

	vec3 out_color=texture(LUT,lut_uvs).rgb;

	COLOR.rgb=out_color;
}