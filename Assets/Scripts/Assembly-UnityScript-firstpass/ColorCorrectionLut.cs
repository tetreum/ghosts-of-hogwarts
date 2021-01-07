using System;
using UnityEngine;

[Serializable]
public class ColorCorrectionLut : PostEffectsBase
{
	public Shader shader;
	public Texture3D converted3DLut;
	public string basedOnTempTex;
}
