using System;
using UnityEngine;

// Token: 0x02000005 RID: 5
public class CandleMove : MonoBehaviour
{
	// Token: 0x06000009 RID: 9 RVA: 0x00002488 File Offset: 0x00000688
	private void Start() {
		if (QualitySettings.GetQualityLevel() == 0) {
			base.enabled = false;
		}
		this.ltPos = base.transform.localPosition;
		this.toPos = this.ltPos;
		this.toPos.y = this.ltPos.y + 1f;
		this.timeMax = UnityEngine.Random.Range(0.8f, 1f);
		this.timeMin = UnityEngine.Random.Range(0f, 0.2f);
		if (UnityEngine.Random.value < 0.5f) {
			this.dir = true;
			this.tParam = this.timeMin;
		} else {
			this.dir = false;
			this.tParam = this.timeMax;
		}
	}

	// Token: 0x0600000A RID: 10 RVA: 0x00002544 File Offset: 0x00000744
	private void Update() {
		if (Vector3.Distance(OVRPlayerController.Instance.transform.position, base.transform.position) < 50f) {
			if (this.dir) {
				this.tParam += Time.deltaTime * this.speed;
			} else if (!this.dir) {
				this.tParam += Time.deltaTime * -this.speed;
			}
			if (this.tParam > this.timeMax) {
				this.dir = false;
			} else if (this.tParam < this.timeMin) {
				this.dir = true;
			}
			base.transform.localPosition = new Vector3(this.ltPos.x, Mathf.SmoothStep(this.ltPos.y, this.ltPos.y + 1f, this.tParam), this.ltPos.z);
		}
	}

	// Token: 0x0400000A RID: 10
	private Vector3 toPos;

	// Token: 0x0400000B RID: 11
	private Vector3 ltPos;

	// Token: 0x0400000C RID: 12
	private float tParam;

	// Token: 0x0400000D RID: 13
	private float speed = 0.05f;

	// Token: 0x0400000E RID: 14
	private bool dir;

	// Token: 0x0400000F RID: 15
	private float timeMax;

	// Token: 0x04000010 RID: 16
	private float timeMin;
}
