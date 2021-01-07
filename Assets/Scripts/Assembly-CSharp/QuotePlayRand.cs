using System;
using System.Collections;
using UnityEngine;

// Token: 0x0200005A RID: 90
public class QuotePlayRand : MonoBehaviour
{
	// Token: 0x060001B3 RID: 435 RVA: 0x00009D08 File Offset: 0x00007F08
	private void Start() {
		this.md = base.GetComponent<AudioSource>().minDistance;
		this.mad = base.GetComponent<AudioSource>().maxDistance;
		this.sPlay = true;
		this.checkone = false;
		this.checktwo = false;
		this.checkthree = true;
		this.block = false;
	}

	// Token: 0x060001B4 RID: 436 RVA: 0x00009D5C File Offset: 0x00007F5C
	private void Update() {
		float distance = Vector3.Distance(OVRPlayerController.Instance.transform.position, base.transform.position);
		if (distance < this.md && this.sPlay && this.checkthree) {
			base.GetComponent<AudioSource>().clip = this.first;
			base.GetComponent<AudioSource>().Play();
			this.sPlay = false;
			this.checkthree = false;
			this.checktwo = false;
			this.checkone = true;
		} else if (distance < this.md && this.sPlay && this.checkone) {
			base.GetComponent<AudioSource>().clip = this.second;
			base.GetComponent<AudioSource>().Play();
			this.sPlay = false;
			this.checkthree = false;
			this.checkone = false;
			this.checktwo = true;
		} else if (distance < this.md && this.sPlay && this.checktwo) {
			if (this.third == null) {
				this.checkone = false;
				this.checktwo = false;
				this.checkthree = true;
			} else {
				base.GetComponent<AudioSource>().clip = this.third;
				base.GetComponent<AudioSource>().Play();
				this.sPlay = false;
				this.checkone = false;
				this.checktwo = false;
				this.checkthree = true;
			}
		} else if (distance > this.mad + this.md && !this.sPlay && !base.GetComponent<AudioSource>().isPlaying) {
			this.sPlay = true;
		} else if (distance < this.md && !this.sPlay && !this.block && !base.GetComponent<AudioSource>().isPlaying && !this.checkthree) {
			base.StartCoroutine(this.Wait());
		}
	}

	// Token: 0x060001B5 RID: 437 RVA: 0x0000A004 File Offset: 0x00008204
	private IEnumerator Wait() {
		this.block = true;
		yield return new WaitForSeconds(this.transition);
		this.sPlay = true;
		this.block = false;
		yield break;
	}

	// Token: 0x0400028C RID: 652
	private float md;

	// Token: 0x0400028D RID: 653
	private float mad;

	// Token: 0x0400028E RID: 654
	private bool sPlay;

	// Token: 0x0400028F RID: 655
	public AudioClip first;

	// Token: 0x04000290 RID: 656
	public AudioClip second;

	// Token: 0x04000291 RID: 657
	public AudioClip third;

	// Token: 0x04000292 RID: 658
	private bool checkone;

	// Token: 0x04000293 RID: 659
	private bool checktwo;

	// Token: 0x04000294 RID: 660
	private bool checkthree;

	// Token: 0x04000295 RID: 661
	private bool block;

	// Token: 0x04000296 RID: 662
	public float transition;
}
