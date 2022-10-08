shader_type canvas_item;

void fragment(){
    vec3 col = texture(TEXTURE,UV).xyz;
	float PI = 3.1415;

	float height = 150.0;
    float width = 256.0;

    float Directions = 10.0; // BLUR DIRECTIONS (Default 16.0 - More is better but slower)
    float Quality = 20.0; // BLUR QUALITY (Default 4.0 - More is better but slower)
    float Size = 2.0; // BLUR SIZE (Radius)
    vec2 Radius = Size/vec2(width,height);

    // blur
    
    for( float d=0.0; d<2.0*PI; d+=2.0*PI/Directions)
    {
		for(float i=1.0/Quality; i<=1.0; i+=1.0/Quality)
        {
			col += texture( TEXTURE, UV+vec2(cos(d),sin(d))*Radius*i).xyz;		
        }
    }

    // Output to screen
    col /= Quality * Directions - 15.0;
    
    // COLOR.xyz = col;
    COLOR = texture(TEXTURE,UV);
}