using System;
using UnityEngine;

// Token: 0x0200000E RID: 14
public class LightningDir : MonoBehaviour
{
	// Token: 0x06000025 RID: 37 RVA: 0x000031F4 File Offset: 0x000013F4
	private void Start() {
		this.ltbase = base.GetComponent<Light>().intensity;
		base.GetComponent<Light>().intensity = 0f;
		if (QualitySettings.GetQualityLevel() == 0) {
			base.enabled = false;
		}
	}

	// Token: 0x06000026 RID: 38 RVA: 0x00003234 File Offset: 0x00001434
	private void Update() {
		if (Time.time - this.lastTime > this.minTime) {
			if (UnityEngine.Random.value > this.thresh) {
				base.GetComponent<Light>().intensity = UnityEngine.Random.Range(0f, this.ltbase);
			} else {
				base.GetComponent<Light>().intensity = 0f;
				this.lastTime = Time.time;
				Quaternion rotation = base.transform.rotation;
				rotation.y = UnityEngine.Random.rotation.y;
				base.transform.rotation = rotation;
			}
		}
	}

	// Token: 0x04000048 RID: 72
	private float minTime = 4f;

	// Token: 0x04000049 RID: 73
	private float thresh = 0.1f;

	// Token: 0x0400004A RID: 74
	private float ltbase;

	// Token: 0x0400004B RID: 75
	private float lastTime;
}
