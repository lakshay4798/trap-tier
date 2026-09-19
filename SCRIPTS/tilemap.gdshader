shader_type canvas_item;

// This creates a dedicated color slot independent of Godot's built-in keywords!
uniform vec4 level_color : source_color = vec4(1.0);

void fragment() {
    vec4 tex = texture(TEXTURE, UV);
    vec3 inverted_color = vec3(1.0) - tex.rgb;
    
    // Multiply by our own custom color variable!
    COLOR = vec4(inverted_color * level_color.rgb, tex.a);
}
