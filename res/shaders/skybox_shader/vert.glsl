#version 330

layout (location = 0) in vec3 position;
layout (location = 1) in vec2 uv;
layout (location = 2) in vec3 normal;

out vec3 pass_position;

uniform mat4 uni_V;
uniform mat4 uni_P;

void main()
{

	pass_position = position;
	
	vec4 view_space_position = uni_V * vec4(position, 0.0);
	view_space_position.w = 1.0;
	
	gl_Position = uni_P * view_space_position;

}