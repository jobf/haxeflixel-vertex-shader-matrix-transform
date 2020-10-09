import flixel.system.FlxAssets.FlxShader;

class VertexTransformShader extends FlxShader
{
	@:glVertexBody("
	// start of default code required for alpha and color to work 
	openfl_Alphav = openfl_Alpha;
	openfl_TextureCoordv = openfl_TextureCoord;
	if (openfl_HasColorTransform) {
		openfl_ColorMultiplierv = openfl_ColorMultiplier;
		openfl_ColorOffsetv = openfl_ColorOffset / 255.0;
	}
	// end of default code
	
	mat4  transform = openfl_Matrix * mat4(
		vec4( tX.x, tX.y, tX.z, 0.0 ),
		vec4( tY.x, tY.y, tY.z, 0.0 ),
		vec4( tZ.x, tZ.y, tZ.z, 0.0 ),
		vec4( tT.x, tT.y, tT.z, 1.0 ));
		
	gl_Position = transform * openfl_Position;
	")
	@:glVertexSource("
	#pragma header

	attribute float alpha;
	attribute vec4 colorMultiplier;
	attribute vec4 colorOffset;
	uniform bool hasColorTransform;

	uniform float iTime;
	
	uniform vec3 tX;
	uniform vec3 tY;
	uniform vec3 tZ;
	uniform vec3 tT;

	void main(void)
	{
		#pragma body
		
		// start of default code required for alpha and color to work 
		openfl_Alphav = openfl_Alpha * alpha;
		if (hasColorTransform)
		{
			openfl_ColorOffsetv = colorOffset / 255.0;
			openfl_ColorMultiplierv = colorMultiplier;
		}
		// end of default code
	}")
	public function new()
	{
		super();
		iTime.value = [0.0];
		tX.value = [1.0, 0.0, 0.0];
		tY.value = [0.0, 1.0, 0.0];
		tZ.value = [0.0, 0.0, 0.0];
		tT.value = [0.0, 0.0, 1.0];
	}

	public function update(elapsed:Float)
	{
		iTime.value[0] += elapsed;
	}
}
