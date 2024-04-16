shader_type canvas_item;

uniform vec4 tint :source_color = vec4(1.0);

uniform float wave_speed = 1.0; //wave loop speed
uniform float wave_freq = 10.0; //wave vertical freq
uniform float wave_width = 0.1; //wave width 
uniform float percent =0.0;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {

	vec2 scale_UV = SCREEN_UV;
	vec2 wave_uv_offset;
	wave_uv_offset.x = cos((TIME*wave_speed * percent )+UV.x+UV.y*wave_freq*2.0)*wave_width*0.01;
	
	vec4 color =texture(TEXTURE,SCREEN_UV);
	
	color = mix(color,tint,0.7);
	
	COLOR = mix(color,texture(SCREEN_TEXTURE,scale_UV+wave_uv_offset),0.5);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
