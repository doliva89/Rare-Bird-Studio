using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PauseMenu : MonoBehaviour {

    public Transform canvas;
    public bool pauseMenu = false;

    private AudioSource[] allAudioSources;

    void Awake()
    {
        allAudioSources = GameObject.FindObjectsOfType(typeof(AudioSource)) as AudioSource[];
    }

	// Update is called once per frame
	void Update () {
		if(Input.GetKeyDown(KeyCode.Escape))
        {
            Pause();
        }
	}

    public void Pause()
    {
        if (canvas.gameObject.activeInHierarchy == false)
        {
            canvas.gameObject.SetActive(true);
            Time.timeScale = 0;
            pauseMenu = true;
            for(int i = 0; i<allAudioSources.Length;i++)
            {
                allAudioSources[i].Pause();
            }
        }
        else
        {
            canvas.gameObject.SetActive(false);
            Time.timeScale = 1;
            pauseMenu = false;
            for (int i = 0; i < allAudioSources.Length; i++)
            {
                allAudioSources[i].UnPause();
            }
        }
    }
}
