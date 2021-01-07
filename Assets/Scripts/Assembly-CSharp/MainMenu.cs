using System;
using System.Collections;
using UnityEngine;

public class MainMenu : MonoBehaviour
{
    private float acceleration = 0.1f;
    private bool inGame;
    private bool camLeave;
    private int timer;
    public AudioClip Depart;
    public AudioClip Arrivee;
    private bool block;
    private bool enter;
    public Texture menu;
    public Texture menuEnter;
    private Color AL;
    public GameObject front;
    public GameObject back;
    public Material skyboxCloud;
    public Material None;
    public SettingsPanel settingsPanel;

    private void Start() {
        this.enter = false;
        this.transform.position = GameObject.Find("MenuSpawn").transform.position;
        this.transform.rotation = Quaternion.identity;
        RenderSettings.skybox = this.None;
        this.AL = RenderSettings.ambientLight;
        RenderSettings.ambientLight = Color.black;
        this.front.SetActive(true);
        this.back.SetActive(true);
        /*
        if (QualitySettings.GetQualityLevel() == 0) {
            GameObject.Find("LeftEyeAnchor").GetComponent<AmbientObscurance>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<AmbientObscurance>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<GlobalFog>().enabled = false;
            GameObject.Find("LeftEyeAnchor").GetComponent<GlobalFog>().enabled = false;
            GameObject.Find("LeftEyeAnchor").GetComponent<FastBloom>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<FastBloom>().enabled = false;
        }
        if (QualitySettings.GetQualityLevel() == 1) {
            GameObject.Find("LeftEyeAnchor").GetComponent<AmbientObscurance>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<AmbientObscurance>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<GlobalFog>().enabled = false;
            GameObject.Find("LeftEyeAnchor").GetComponent<GlobalFog>().enabled = false;
            GameObject.Find("LeftEyeAnchor").GetComponent<FastBloom>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<FastBloom>().enabled = false;
        }
        if (QualitySettings.GetQualityLevel() == 2) {
            GameObject.Find("LeftEyeAnchor").GetComponent<AmbientObscurance>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<AmbientObscurance>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<GlobalFog>().enabled = false;
            GameObject.Find("LeftEyeAnchor").GetComponent<GlobalFog>().enabled = false;
            GameObject.Find("LeftEyeAnchor").GetComponent<FastBloom>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<FastBloom>().enabled = false;
        }
        if (QualitySettings.GetQualityLevel() == 3) {
            GameObject.Find("RightEyeAnchor").GetComponent<GlobalFog>().enabled = false;
            GameObject.Find("LeftEyeAnchor").GetComponent<GlobalFog>().enabled = false;
            GameObject.Find("LeftEyeAnchor").GetComponent<FastBloom>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<FastBloom>().enabled = false;
        }
        if (QualitySettings.GetQualityLevel() == 4) {
            GameObject.Find("LeftEyeAnchor").GetComponent<FastBloom>().enabled = false;
            GameObject.Find("RightEyeAnchor").GetComponent<FastBloom>().enabled = false;
        }
        if (QualitySettings.GetQualityLevel() != 5) { }
        */
    }

    private void Update() {
        if (Input.GetKeyDown(KeyCode.Escape) && enter) {
            settingsPanel.gameObject.SetActive(!settingsPanel.gameObject.activeSelf);
        }
        if (Input.GetKeyDown(KeyCode.Return)) {
            this.enter = true;
        }
        if (Input.GetKeyDown(KeyCode.Return) && !this.inGame || Input.GetKeyDown(KeyCode.KeypadEnter) && !this.inGame && !this.block) {
            this.camLeave = true;
            this.GetComponent<AudioSource>().clip = this.Depart;
            this.GetComponent<AudioSource>().volume = 1f;
            this.GetComponent<AudioSource>().Play();
            this.StartCoroutine(this.Leaving());
        } else if (Input.GetKeyDown(KeyCode.Return) && this.inGame || Input.GetKeyDown(KeyCode.KeypadEnter) && this.inGame && !this.block) {
            playArrivee();
            this.camLeave = true;
            this.StartCoroutine(this.LeavingShort());
        }
        if (Input.GetKeyDown(KeyCode.KeypadPlus))
            AudioListener.volume += 0.1f;
        else if (Input.GetKeyDown(KeyCode.KeypadMinus))
            AudioListener.volume -= 0.1f;
        if (!this.camLeave)
            return;

        if (!this.enter) {
            return;
        }

        ++this.timer;
        if ((double)this.acceleration < 60.0)
            this.acceleration *= 1.3f;
        this.transform.Translate(Vector3.back * Time.deltaTime * this.acceleration, Space.Self);
    }

    private IEnumerator Leaving() {
        this.block = true;
        yield return new WaitForSeconds(3.5f);
        RenderSettings.ambientLight = this.AL;
        RenderSettings.skybox = this.skyboxCloud;
        this.camLeave = false;
        this.timer = 0;
        this.acceleration = 0.1f;
        base.transform.position = GameObject.Find("ApparateSpawn").transform.position;
        base.transform.rotation = Quaternion.Euler(0f, 155.448f, 0f);
        this.inGame = true;
        base.GetComponent<CharacterController>().enabled = true;
        base.GetComponent<OVRPlayerController>().enabled = true;
        GameObject.Find("Lumos").GetComponent<Light>().intensity = 0f;
        this.block = false;
        yield break;
    }

    // Token: 0x0600002E RID: 46 RVA: 0x00003958 File Offset: 0x00001B58
    private IEnumerator LeavingShort() {
        this.block = true;
        yield return new WaitForSeconds(0.8f);
        RenderSettings.skybox = this.None;
        RenderSettings.ambientLight = Color.black;
        this.camLeave = false;
        this.timer = 0;
        this.acceleration = 0.1f;
        base.transform.position = GameObject.Find("MenuSpawn").transform.position;
        base.transform.rotation = Quaternion.identity;
        this.inGame = false;
        base.GetComponent<OVRPlayerController>().enabled = false;
        this.block = false;
        yield break;
    }

    public void playArrivee () {
        this.GetComponent<AudioSource>().clip = this.Arrivee;
        this.GetComponent<AudioSource>().volume = 1f;
        this.GetComponent<AudioSource>().Play();
    }
}
