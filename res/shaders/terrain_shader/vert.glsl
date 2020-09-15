#version 330

layout (location = 0) in vec3 position;
layout (location = 1) in vec2 uv;
layout (location = 2) in vec3 normal;

out vec3 pass_world_position;
out vec3 pass_normal;

uniform float uni_terrain_size;
uniform float uni_time;

uniform mat4 uni_V;
uniform mat4 uni_P;
uniform mat4 uni_M;

uniform sampler2D uni_heightmap_tex;

void main()
{

	float r = texture( uni_heightmap_tex, vec2( position.x / uni_terrain_size, position.z / uni_terrain_size ) ).x;

	r = r / 256;
	r = r * 10;

	float y_offset = 1.7 * sin(uni_time / 2 + (position.x / uni_terrain_size) * 3 - position.z);

	vec3 vertex = vec3(position.x, y_offset, position.z);

	vec4 world_position = uni_M * vec4(vertex, 1.0);
	
	pass_normal = vec3(0.0, y_offset, 0.0);
	
	pass_world_position = world_position.xyz;
	
	vec4 view_space_position = uni_V * world_position;
	vec4 clip_space_position = uni_P * view_space_position;
	
	gl_Position = clip_space_position;

}