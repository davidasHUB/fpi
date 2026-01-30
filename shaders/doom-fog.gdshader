shader_type spatial;
render_mode unshaded;

uniform sampler2D main_texture : source_color, filter_nearest;
uniform sampler2D palette_tex : filter_nearest;
uniform sampler2D colormap_tex : filter_linear;

uniform float max_dist = 20.0;
const float fake_contrast_intensity = 0.2;

void fragment() {
    // 1. TEXTURA E ÍNDICE (Eixo X)
    vec3 base_color = texture(main_texture, UV).rgb;
    int palette_size = textureSize(palette_tex, 0).x;

    float best_dist = 10.0;
    float best_u = 0.0;
    for (int i = 0; i < palette_size; i++) {
        float u = (float(i) + 0.5) / float(palette_size);
        vec3 p_col = texture(palette_tex, vec2(u, 0.5)).rgb;
        float d = distance(base_color, p_col);
        if (d < best_dist) {
            best_dist = d;
            best_u = u;
        }
    }

    // 2. PROFUNDIDADE CILÍNDRICA (Distância da Câmera, Ignora Pitch)
    float z_depth = -VERTEX.z;

    // 3. FAKE CONTRAST GLOBAL (Posição no Mundo)
    // Transformamos a normal do objeto para o espaço do MUNDO
    vec3 world_normal = (INV_VIEW_MATRIX * vec4(NORMAL, 0.0)).xyz;

    // Doom clássico: Paredes alinhadas ao eixo X global vs eixo Z global
    // Se a parede está "olhando" para o Leste ou Oeste (X), aplicamos o contraste
    float world_side_view = abs(world_normal.x);

    // Filtro para garantir que o chão (Y) não receba o contraste de parede
    float wall_mask = clamp(1.0 - abs(world_normal.y), 0.0, 1.0);

    // Cálculo do contraste fixo
    float contrast = world_side_view * wall_mask * fake_contrast_intensity;

    // 4. SELEÇÃO DA LINHA NO COLORMAP (Eixo Y)
    // A luz depende da distância da câmera + a orientação fixa da parede no mundo
    float light_row = clamp((z_depth / max_dist) + contrast, 0.0, 0.98);

    // 5. FINALIZAÇÃO
    ALBEDO = texture(colormap_tex, vec2(best_u, light_row)).rgb;
}