using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameMusicManager : MonoBehaviour {

    public AudioClip[] playList;

    private AudioSource source;

    private PauseMenu pauseAudio;

    void Awake()
    {
        source = GetComponent<AudioSource>();
        pauseAudio = GetComponentInParent<PauseMenu>();
    }
	
	// Update is called once per frame
	void Update () {
		if(!source.isPlaying && !pauseAudio.pauseMenu)
        {
            PlayMusic();
        }
        
	}

    void PlayMusic()
    {
        int randomSong = Random.Range(0, playList.Length);
        source.clip = playList[randomSong];
        source.Play();
    }
}
