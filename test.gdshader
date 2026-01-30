shader_type spatial;

uniform sampler2D albedo_map : source_color, filter_nearest_mipmap;
uniform sampler2D LUT : source_color, filter_nearest_mipmap;
uniform vec4 modu : source_color = vec4(1.0);
void vertex() {
	// Called for every vertex the material is visible on.
}

/*



*/
void fragment() {
	vec3 color = texture(albedo_map,UV).rgb * modu.rgb;
	float cell_count = 8.0;
	float color_number = 64.0;

	vec3 index = clamp(color * color_number, 0.0, color_number-1.0);
	vec2 blue_index = mod(floor(index.b / vec2(1.0,cell_count)),cell_count);
	vec2 lut_uvs = (index.rg / color_number + blue_index)/ cell_count;

	vec3 out_color=texture(LUT,lut_uvs).rgb;

	ALBEDO = out_color;

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
