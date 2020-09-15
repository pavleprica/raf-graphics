#version 330

layout (location = 0) in vec3 position;
layout (location = 1) in vec2 uv;
layout (location = 2) in vec3 normal;

out vec3 pass_world_position;
out vec3 pass_normal;

uniform mat4 uni_V;
uniform mat4 uni_P;
uniform mat4 uni_M;

void main()
{

	vec4 world_position = uni_M * vec4(position, 1.0);
	
	pass_normal = (uni_M * vec4(position, 0.0)).xyz;
	
	pass_world_position = world_position.xyz;
	
	vec4 view_space_position = uni_V * world_position;
	vec4 clip_space_position = uni_P * view_space_position;
	
	gl_Position = clip_space_position;

}