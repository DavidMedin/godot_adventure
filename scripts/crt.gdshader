shader_type canvas_item;

uniform float extra;

float rand(vec2 co){
    return fract(sin(dot(co, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
	float PI = 3.1415;

    float screen_width = 1024.0;
    float screen_height = 600.0;

	float height = 1024.0;
    float width = 600.0;

	float line_num = round(screen_height / 4.0);
    float pix_num = (screen_width/6.0) * 1.0;
	float pix_width = screen_width / pix_num;
	float pix_height = screen_height / line_num;

    vec3 col = texture(TEXTURE,UV).xyz;

	float darkness = cos(UV.y*line_num* 2.0*PI)+1.0;
	int y_offset = int(pix_height)/2;
	
    float is_up = sin(UV.x*pix_num*PI);

	if(is_up > 0.0) {
		darkness = cos(UV.y*line_num* 2.0*PI+PI)+1.0;
		y_offset = 0;
	}
    if(darkness > 0.293) {
        darkness = 1.0;
    }
	
	float sub_width = pix_width / 3.0;
	float sub_height = pix_height;
	float r_start_x = ((UV.x * screen_width) - float(int((UV * screen_width).x) % int(sub_width))) / screen_width;
	float r_end_x = ((UV.x*screen_width) - float(int((UV * screen_width).x) % int(sub_width)) + sub_width/2.0) / screen_width;

	float g_start_x = ((UV.x * screen_width) - float(int((UV * screen_width+sub_width).x) % int(sub_width))) / screen_width;
	float g_end_x = ((UV.x*screen_width) - float(int((UV * screen_width+sub_width).x) % int(sub_width)) + sub_width/2.0) / screen_width;

	float b_start_x = ((UV.x * screen_width) - float(int((UV * screen_width+sub_width*2.0).x) % int(sub_width))) / screen_width;
	float b_end_x = ((UV.x*screen_width) - float(int((UV * screen_width+sub_width*2.0).x) % int(sub_width)) + sub_width/2.0) / screen_width;

	float start_y = float( int(UV.y*screen_height) + y_offset - (int(UV.y * screen_height) + y_offset) % int(pix_height)) / screen_height;
	float end_y = float( int(UV.y*screen_height) + y_offset - (int(UV.y * screen_height) + y_offset) % int(pix_height) + int(pix_height)/2 ) / screen_height;

	vec3 new_col = vec3(0);
	new_col.x = (texture(TEXTURE,vec2(r_start_x,start_y)).x + texture(TEXTURE,vec2(r_end_x,start_y)).x + texture(TEXTURE,vec2(r_start_x,end_y)).x + texture(TEXTURE,vec2(r_end_x,end_y)).x + col.x) / 5.0;
	new_col.y = (texture(TEXTURE,vec2(g_start_x,start_y)).y + texture(TEXTURE,vec2(g_end_x,start_y)).y + texture(TEXTURE,vec2(g_start_x,end_y)).y + texture(TEXTURE,vec2(g_end_x,end_y)).y + col.y) / 5.0;
	new_col.z = (texture(TEXTURE,vec2(b_start_x,start_y)).z + texture(TEXTURE,vec2(b_end_x,start_y)).z + texture(TEXTURE,vec2(b_start_x,end_y)).z + texture(TEXTURE,vec2(b_end_x,end_y)).z + col.z) / 5.0;
	
	//new_col.x = (texture(TEXTURE,vec2(r_end_x,end_y)).x + col.x) / 2.0;
	//new_col.y = (texture(TEXTURE,vec2(g_end_x,end_y)).y + col.y) / 2.0;
	//new_col.z = (texture(TEXTURE,vec2(b_end_x,end_y)).z + col.z) / 2.0;
	
	col = new_col;
	
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
    float r_str = (rng * r_cos) * extra;
    float g_str = (rng * g_cos) * extra;
    float b_str = (rng * b_cos) * extra;
    // apply black bands
	col *= darkness;
    col = vec3(col.x*r_str,col.y*g_str,col.z*b_str);
	COLOR.xyz = col.xyz;
}
