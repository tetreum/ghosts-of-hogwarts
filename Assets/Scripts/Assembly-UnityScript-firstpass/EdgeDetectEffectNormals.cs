using System;
using UnityEngine;

[Serializable]
public class EdgeDetectEffectNormals : PostEffectsBase
{
	public EdgeDetectMode mode;
	public float sensitivityDepth;
	public float sensitivityNormals;
	public float lumThreshhold;
	public float edgeExp;
	public float sampleDist;
	public float edgesOnly;
	public Color edgesOnlyBgColor;
	public Shader edgeDetectShader;
}
