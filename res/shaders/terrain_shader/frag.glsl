#version 330


in vec3 pass_world_position;
in vec3 pass_normal;

out vec4 out_colour;

uniform vec3 camera_position;
uniform vec3 light_direction;

uniform vec3 uni_camera_position;
uniform vec3 uni_light_direction;

const vec3 light_colour = vec3(1.0, 0.9, 0.7);
const vec3 object_colour = vec3(1.0, 1.0, 0.2);

const float ambient_factor = 0.1;

void main()
{

	vec3 normalized_normal = normalize(pass_normal);
	float diffuse_factor = dot(normalized_normal, normalize(-uni_light_direction));
	
	diffuse_factor = clamp(diffuse_factor, ambient_factor, 1.0);
	
	vec3 diffuse_colour = object_colour * light_colour * diffuse_factor;
	
	vec3 view_vector = normalize(pass_world_position - camera_position);
	
	vec3 reflected_light_direction = reflect(normalize(uni_light_direction), normalized_normal);
	
	float specular_factor = dot(reflected_light_direction, view_vector * (-1.0));
	specular_factor = clamp(specular_factor, 0, 1);
	specular_factor = pow(specular_factor, 5);
	
	vec3 specular_colour = light_colour * specular_factor;
	
	vec3 final_color = diffuse_colour + pass_world_position / 2;

	out_colour = vec4(final_color, 1.0);

}