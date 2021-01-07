using System;
using UnityEngine;

[Serializable]
public class TiltShiftHdr : PostEffectsBase
{
	public enum TiltShiftMode
	{
		TiltShiftMode = 0,
		IrisMode = 1,
	}

	public enum TiltShiftQuality
	{
		Preview = 0,
		Normal = 1,
		High = 2,
	}

	public TiltShiftMode mode;
	public TiltShiftQuality quality;
	public float blurArea;
	public float maxBlurSize;
	public int downsample;
	public Shader tiltShiftShader;
}
