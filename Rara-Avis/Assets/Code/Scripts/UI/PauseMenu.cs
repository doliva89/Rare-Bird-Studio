using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

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
		if(Input.GetButtonDown("Cancel"))
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

    public void RestartLevel()
    {
        Scene loadedLevel = SceneManager.GetActiveScene();
        SceneManager.LoadScene(loadedLevel.name);
        Time.timeScale = 1;
    }

    public void QuitLevel()
    {
        Application.Quit();
    }

    public void MainMenu()
    {
        SceneManager.LoadScene("GameMenu");
        Time.timeScale = 1;
    }
}
