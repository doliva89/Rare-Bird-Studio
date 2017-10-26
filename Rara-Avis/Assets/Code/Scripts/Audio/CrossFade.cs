using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CrossFade : MonoBehaviour {

    public static CrossFade Instance;

    void Awake(){
        Instance = this;
    }

	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    public static void Crossfade(AudioClip newClip, float fadeTime = 1.0f)
    {
        Instance.StopAllCoroutines();

        if (Instance.GetComponents<AudioSource>().Length > 1)
        {
            Destroy(Instance.GetComponent<AudioSource>());
        }

        AudioSource newAudioSource = Instance.gameObject.AddComponent<AudioSource>();

        newAudioSource.volume = 0.0f;

        newAudioSource.clip = newClip;

        newAudioSource.Play();

        Instance.StartCoroutine(Instance.ActualCrossfade(newAudioSource, fadeTime));
    }

    IEnumerator ActualCrossfade(AudioSource newSource, float fadeTime)
    {
        float t = 0.0f;

        float initialVolume = GetComponent <AudioSource>().volume;

        while(t < fadeTime)
        {
            GetComponent<AudioSource>().volume = Mathf.Lerp(initialVolume, 0.0f, t / fadeTime);
            newSource.volume = Mathf.Lerp(0.0f, 1.0f, t / fadeTime);

            t += Time.deltaTime;
            yield return null;
        }

        newSource.volume = 1.0f;

        Destroy(GetComponent<AudioSource>());
    }
}
