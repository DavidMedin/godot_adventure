shader_type canvas_item;

uniform float r_offset;

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {

    float screen_width = 1024.0;
    float screen_height = 600.0;

	float height = 150.0;
    float width = 256.0;

	float line_num = 100.0;
	// float pix_num = 200.0;
    float pix_num = (screen_width/3.0) * 0.5;

    vec3 col = texture(TEXTURE,UV).xyz;
    col.x = texture(TEXTURE,UV + vec2((r_offset*2.0)/screen_width,0)).x;
	float PI = 3.1415;

	float darkness = sin(UV.y*line_num* 2.0*PI)+1.0;
	
    float is_up = sin(UV.x*pix_num*PI);
	if(is_up > 0.0) {
		darkness = sin(UV.y*line_num* 2.0*PI +PI)+1.0;
	}
    if(darkness > 0.1) {
        darkness = 1.0;
    }
	
	float r_cos = sin(UV.x*pix_num*(2.0*PI) + PI/6.0);

	float g_cos = sin(UV.x*pix_num*(2.0*PI) + (2.0*PI)/3.0 + PI/6.0);
	float b_cos = sin(UV.x*pix_num*(2.0*PI) + (4.0*PI)/3.0 + PI/6.0);

    float margin = 0.7;

    if(r_cos < margin){
        r_cos = 0.0;
    }
    if(g_cos < margin) {
        g_cos = 0.0;
    }
    if(b_cos < margin) {
        b_cos = 0.0;
    }
    float rng = 1.0;//rand(UV.xy);
    float r_str = rng * r_cos;
    float g_str = rng * g_cos;
    float b_str = rng * b_cos;


    // apply black bands
	col *= darkness;

    col = vec3(col.x*r_str,col.y*g_str,col.z*b_str);
    COLOR.xyz = col;
    //COLOR = texture(TEXTURE,UV);
}
