class ScalingVertexShader extends VertexTransformShader
{
	public function setScale(scale:Float)
	{
		tX.value[0] = scale;
		tY.value[1] = scale;
	}
}
