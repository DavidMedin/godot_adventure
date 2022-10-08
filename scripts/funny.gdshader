shader_type canvas_item;

void fragment() {
    vec3 col = texture(TEXTURE,UV).xyz;
	float PI = 3.1415;
	float height = 216.0;
	float line_num = 50.0;
	float pix_num = 100.0;
	float darkness = (cos(UV.y*line_num* ((2.0*PI)/1.0)) * 1.0 )+1.0;
	float is_up = cos(UV.x*(pix_num/3.0)*2.0*PI);
	if(is_up > 0.0) {
		darkness = (cos((UV.y*line_num+0.5)* ((2.0*PI)/1.0)) * 1.0 )+1.0;
	}
	col *= darkness;
	
	float r_cos = sin(UV.x*pix_num*(2.0*PI) + PI/6.0);
	float g_cos = sin(UV.x*pix_num*(2.0*PI) + (2.0*PI)/3.0 + PI/6.0);
	float b_cos = sin(UV.x*pix_num*(2.0*PI) + (4.0*PI)/3.0 + PI/6.0);

	//float r_cos = cos(UV.x*pix_num*2.0*PI               ); //+ PI/6.0);
	//float g_cos = cos(UV.x*pix_num*2.0*PI + (2.0*PI)/3.0); //+ PI/6.0);
	//float b_cos = cos(UV.x*pix_num*2.0*PI + (4.0*PI)/3.0); //+ PI/6.0);
    COLOR.xyz = vec3(col.x*r_cos,col.y*g_cos,col.z*b_cos);
}
