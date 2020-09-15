#version 330


in vec3 pass_world_position;
in vec3 pass_normal;

out vec4 out_colour;

uniform vec3 camera_position;
uniform vec3 light_direction;
uniform vec3 light_colour;
uniform vec3 object_colour;

const float ambient_factor = 0.1;

void main()
{

	vec3 normalized_normal = normalize(pass_normal);
	float diffuse_factor = dot(normalized_normal, normalize(-light_direction));
	
	diffuse_factor = clamp(diffuse_factor, ambient_factor, 1.0);
	
	vec3 diffuse_colour = object_colour * light_colour * diffuse_factor;
	
	vec3 view_vector = normalize(pass_world_position - camera_position);
	
	vec3 reflected_light_direction = reflect(normalize(light_direction), normalized_normal);
	
	float specular_factor = dot(reflected_light_direction, view_vector *(-1.0));
	specular_factor = clamp(specular_factor, 0, 1);
	specular_factor = pow(specular_factor, 5);
	
	vec3 specular_colour = light_colour * specular_factor;
	
	

	out_colour = vec4(specular_colour, 1.0);

}