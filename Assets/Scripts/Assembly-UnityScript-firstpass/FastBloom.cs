using System;
using UnityEngine;

[Serializable]
public class FastBloom : PostEffectsBase
{
	public enum Resolution
	{
		Low = 0,
		High = 1,
	}

	public enum BlurType
	{
		Standard = 0,
		Sgx = 1,
	}

	public float threshhold;
	public float intensity;
	public float blurSize;
	public Resolution resolution;
	public int blurIterations;
	public BlurType blurType;
	public Shader fastBloomShader;
}
