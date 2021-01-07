using System;
using UnityEngine;

// Token: 0x0200005D RID: 93
public class TerrainQuality : MonoBehaviour
{
	// Token: 0x060001BD RID: 445 RVA: 0x0000A328 File Offset: 0x00008528
	private void Start() {
		if (QualitySettings.GetQualityLevel() == 0) {
			Terrain.activeTerrain.detailObjectDensity = 0f;
			Terrain.activeTerrain.treeDistance = 100f;
			Terrain.activeTerrain.treeBillboardDistance = 5f;
			Terrain.activeTerrain.treeCrossFadeLength = 5f;
		}
		if (QualitySettings.GetQualityLevel() == 1) {
			Terrain.activeTerrain.detailObjectDensity = 0.3f;
			Terrain.activeTerrain.detailObjectDistance = 10f;
			Terrain.activeTerrain.treeDistance = 200f;
			Terrain.activeTerrain.treeBillboardDistance = 10f;
			Terrain.activeTerrain.treeCrossFadeLength = 10f;
		}
		if (QualitySettings.GetQualityLevel() == 2) {
			Terrain.activeTerrain.detailObjectDensity = 0.5f;
			Terrain.activeTerrain.detailObjectDistance = 20f;
			Terrain.activeTerrain.treeBillboardDistance = 30f;
			Terrain.activeTerrain.treeCrossFadeLength = 20f;
		}
		if (QualitySettings.GetQualityLevel() == 3) {
			Terrain.activeTerrain.detailObjectDistance = 30f;
		}
		if (QualitySettings.GetQualityLevel() == 4) {
		}
		if (QualitySettings.GetQualityLevel() == 5) {
			Terrain.activeTerrain.detailObjectDistance = 80f;
		}
	}
}
