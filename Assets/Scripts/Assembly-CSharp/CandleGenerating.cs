using System;
using UnityEngine;

// Token: 0x02000004 RID: 4
public class CandleGenerating : MonoBehaviour
{
	// Token: 0x06000007 RID: 7 RVA: 0x00002268 File Offset: 0x00000468
	private void OnEnable() {
		if (QualitySettings.GetQualityLevel() == 0) {
			base.enabled = false;
		}
		if (QualitySettings.GetQualityLevel() == 1) {
			this.nbrCandles = 50;
		}
		if (QualitySettings.GetQualityLevel() == 2) {
			this.nbrCandles = 80;
		}
		if (QualitySettings.GetQualityLevel() == 3) {
			this.nbrCandles = 120;
		}
		if (QualitySettings.GetQualityLevel() == 4) {
			this.nbrCandles = 150;
		}
		if (QualitySettings.GetQualityLevel() == 5) {
			this.nbrCandles = 200;
		}
		float min = -base.transform.localScale.x / 2f;
		float max = base.transform.localScale.x / 2f;
		float min2 = -base.transform.localScale.y / 2f;
		float max2 = base.transform.localScale.y / 2f;
		float min3 = -base.transform.localScale.z / 2f;
		float max3 = base.transform.localScale.z / 2f;
		this.posCube = base.transform.position;
		for (int i = 0; i < this.nbrCandles; i++) {
			this.position = this.posCube;
			this.position.x = this.position.x + UnityEngine.Random.Range(min, max);
			this.position.y = this.position.y + UnityEngine.Random.Range(min2, max2);
			this.position.z = this.position.z + UnityEngine.Random.Range(min3, max3);
			this.Instance = (UnityEngine.Object.Instantiate(this.prefab, this.position, this.prefab.transform.rotation) as GameObject);
			this.Instance.name = "CandleGen";
			this.Instance.transform.parent = GameObject.Find("CandleGeneratorBox").transform;
		}
	}

	// Token: 0x04000005 RID: 5
	public GameObject prefab;

	// Token: 0x04000006 RID: 6
	private Vector3 posCube;

	// Token: 0x04000007 RID: 7
	private Vector3 position;

	// Token: 0x04000008 RID: 8
	private int nbrCandles;

	// Token: 0x04000009 RID: 9
	private GameObject Instance;
}
