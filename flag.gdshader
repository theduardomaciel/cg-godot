shader_type spatial;

// The noise texture driving distortion
uniform sampler2D uv_offset_texture : source_color, filter_linear, repeat_enable;
// The main flag image to display
uniform sampler2D flag_texture : source_color, filter_linear, repeat_enable;

uniform vec2 uv_offset_scale = vec2(-0.2, -0.1);
uniform vec2 time_scale      = vec2(0.3,  0.0);
uniform float face_distortion = 0.5;

varying vec2 v_uv;  // pass UV to fragment

void vertex() {
    v_uv = UV;

    // Compute offset UV for noise sampling
    vec2 base_uv_offset = UV * uv_offset_scale;
    base_uv_offset += TIME * time_scale;

    float noise = texture(uv_offset_texture, base_uv_offset).r;
    float texture_based_offset = noise * 2.0 - 1.0;
    texture_based_offset *= UV.x;

    VERTEX.y += texture_based_offset;
    VERTEX.z += texture_based_offset * face_distortion;
    VERTEX.x += texture_based_offset * -face_distortion;
}

void fragment() {
    // Sample the flag texture at the original UV
    vec3 col = texture(flag_texture, v_uv).rgb;
    ALBEDO = col;
}