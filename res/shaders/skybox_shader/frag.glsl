#version 330


in vec3 pass_position;

out vec4 out_colour;

uniform samplerCube skybox_sampler;

void main()
{

	out_colour = texture(skybox_sampler, pass_position);

}