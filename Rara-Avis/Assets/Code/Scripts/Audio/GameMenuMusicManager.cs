using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GameMenuMusicManager : MonoBehaviour {

    public AudioClip[] playList;
    public float musicVolume = 0.5f;


    private AudioSource source;



    void Awake()
    {
        source = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        if (!source.isPlaying)
        {
            PlayMusic();
        }

    }

    void PlayMusic()
    {
        source.volume = musicVolume;
        int randomSong = Random.Range(0, playList.Length);
        source.clip = playList[randomSong];
        source.Play();
    }
}
