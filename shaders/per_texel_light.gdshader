shader_type spatial;

#define DIFFUSE_LAMBERT
#define SPECULAR_SCHLICK_GGX

#include "standard_lighting.gdshaderinc"
// Calculate screen-space displacement from the center of the current texel
vec2 screen_delta(vec2 uv, sampler2D tex) {
	vec2 tex_size = vec2(textureSize(tex, 0));
	vec2 texel_center = (floor(uv * tex_size) + 0.5) / tex_size;
	vec2 offset = texel_center - uv;
	mat2 screen_to_uv = mat2(dFdx(uv), dFdy(uv));
	mat2 uv_to_screen = inverse(screen_to_uv);
	return uv_to_screen * offset;
}

// Snap vec_type to extrapolated value at the center of the current texel
float texel_snap(float v, vec2 delta) {
	return v + dFdx(v) * delta.x + dFdy(v) * delta.y;
}

vec2 texel_snap(vec2 v, vec2 delta) {
	return v + dFdx(v) * delta.x + dFdy(v) * delta.y;
}

vec3 texel_snap(vec3 v, vec2 delta) {
	return v + dFdx(v) * delta.x + dFdy(v) * delta.y;
}

vec4 texel_snap(vec4 v, vec2 delta) {
	return v + dFdx(v) * delta.x + dFdy(v) * delta.y;
}

uniform sampler2D albedo_map : source_color, filter_nearest_mipmap;
uniform sampler2D normal_map : hint_normal, filter_nearest_mipmap;
uniform float roughness : hint_range(0.0, 1.0) = 1.0;
uniform float metallic : hint_range(0.0, 1.0) = 0.0;
uniform vec2 uv_tiling = vec2(1.0);
uniform vec2 uv_offset = vec2(0.0);

void vertex() {
	UV = (UV + uv_offset) * uv_tiling;
}

void fragment() {
	// Snap LIGHT_VERTEX and NORMAL for pixelated shadows
	vec2 delta = screen_delta(UV, albedo_map);
	LIGHT_VERTEX = texel_snap(VERTEX, delta);
	NORMAL = texel_snap(NORMAL, delta);





	ALBEDO = texture(albedo_map, UV).rgb;
	NORMAL_MAP = texture(normal_map, UV).xyz;
	ROUGHNESS = roughness;
	METALLIC = metallic;

	// Specular reflections produce filtering artifacts with this method, so disable them
	RADIANCE = vec4(vec3(0.0), 1.0);
}

void light() {
	vec3 d = vec3(0.0), s = vec3(0.0);
	STANDARD_LIGHTING(d, s);

	DIFFUSE_LIGHT += ALBEDO * d + s;
	float l = float(100);
	SPECULAR_LIGHT = floor(DIFFUSE_LIGHT * l) / l;
	SPECULAR_LIGHT -= ALBEDO * DIFFUSE_LIGHT;
}