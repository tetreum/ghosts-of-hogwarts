using System;
using System.Collections;
using UnityEngine;

// Token: 0x02000058 RID: 88
public class PassageSecret : MonoBehaviour
{

	// Token: 0x04000281 RID: 641
	public GameObject Sortie;

	// Token: 0x04000282 RID: 642
	public bool block;

	// Token: 0x04000283 RID: 643
	private Quaternion temp;

	// Token: 0x04000284 RID: 644
	private bool leave;

	// Token: 0x04000285 RID: 645
	private float i;

	// Token: 0x04000286 RID: 646
	private float LExp;

	// Token: 0x04000287 RID: 647
	private float RExp;

	// Token: 0x04000288 RID: 648
	private bool arrive;

	// Token: 0x060001AB RID: 427 RVA: 0x00009A0C File Offset: 0x00007C0C
	private void OnTriggerEnter(Collider other) {
		this.i = 1f;
		/*this.LExp = GameObject.Find("LeftEyeAnchor").GetComponent<ScreenOverlay>().intensity;
		this.RExp = GameObject.Find("RightEyeAnchor").GetComponent<ScreenOverlay>().intensity;*/
		if (!this.block) {
			this.leave = true;
			OVRPlayerController.Instance.setCharacterControllerEnabled(false);
			base.StartCoroutine(this.Wait());
		}
	}

	// Token: 0x060001AC RID: 428 RVA: 0x00009A78 File Offset: 0x00007C78
	private void OnTriggerExit(Collider other) {
		this.block = false;
	}

	// Token: 0x060001AD RID: 429 RVA: 0x00009A84 File Offset: 0x00007C84
	private IEnumerator Wait() {
		OVRPlayerController.Instance.GetComponent<MainMenu>().playArrivee();
		yield return new WaitForSeconds(1f);
		this.Sortie.GetComponentInParent<DisableGOcollider>().showChilds(true);
		this.Sortie.GetComponent<PassageSecret>().block = true;
		Debug.Log("Moving to " + this.Sortie.name);
		OVRPlayerController.Instance.transform.position = this.Sortie.transform.position;
		this.temp = this.Sortie.transform.rotation;
		OVRPlayerController.Instance.transform.rotation = this.temp;
		this.leave = false;
		GetComponentInParent<DisableGOcollider>().showChilds(false);
		OVRPlayerController.Instance.setCharacterControllerEnabled(true);
		yield break;
	}

	// Token: 0x060001AE RID: 430 RVA: 0x00009AA0 File Offset: 0x00007CA0
	private void Update() {
		if (this.leave && this.i > 0f) {
			this.i -= Time.deltaTime;
			this.LExp += Time.deltaTime;
			this.RExp += Time.deltaTime;
			/*GameObject.Find("LeftEyeAnchor").GetComponent<ScreenOverlay>().intensity = this.LExp;
			GameObject.Find("RightEyeAnchor").GetComponent<ScreenOverlay>().intensity = this.RExp;*/
			AudioListener.volume -= Time.deltaTime;
		}
		if (this.block) {
			this.arrive = true;
		}
		if (this.arrive) {
			if (this.i > 0f) {
				this.i -= Time.deltaTime;
				this.LExp -= Time.deltaTime;
				this.RExp -= Time.deltaTime;
				/*GameObject.Find("LeftEyeAnchor").GetComponent<ScreenOverlay>().intensity = this.LExp;
				GameObject.Find("RightEyeAnchor").GetComponent<ScreenOverlay>().intensity = this.RExp;*/
				AudioListener.volume += Time.deltaTime;
			} else if (this.i <= 0f) {
				this.arrive = false;
			}
		}
	}

}
