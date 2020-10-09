package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var isShaderEnabled:Bool;
	var shader:ScalingVertexShader;
	var bg:FlxSprite;
	var scale:Float;

	override public function create()
	{
		super.create();

		scale = 1.0;
		shader = new ScalingVertexShader();

		bg = new FlxSprite(0, 0, "assets/images/jungle.png");
		bg.shader = shader;
		add(bg);

		initHelpDisplay();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (isShaderEnabled)
		{
			shader.update(elapsed);
		}

		if (FlxG.keys.justPressed.UP)
		{
			scale += 0.1;
			shader.setScale(scale);
		}

		if (FlxG.keys.justPressed.DOWN)
		{
			if (scale > 0.1)
			{
				scale -= 0.1;
			}
			shader.setScale(scale);
		}
	}

	function initHelpDisplay()
	{
		var helpBg = new FlxSprite(0, 396);
		helpBg.makeGraphic(FlxG.width, FlxG.height - 396, FlxColor.BLACK);
		helpBg.alpha = 0.2;
		add(helpBg);

		var helpText = new FlxText(0, 419, 512, "Press up or down to increase or decrease scale", 20);
		helpText.alignment = CENTER;
		add(helpText);
	}
}
