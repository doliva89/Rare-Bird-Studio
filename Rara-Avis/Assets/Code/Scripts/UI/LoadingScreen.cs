using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class LoadingScreen : MonoBehaviour
{

    public GameObject loadingScreenObj;
    public GameObject MainMenuObj;
    public Slider slider;

    AsyncOperation async;


    public void LoadScreen()
    {
        StartCoroutine(LoadingScreenA());
    }

    IEnumerator LoadingScreenA()
    {
        loadingScreenObj.SetActive(true);
        MainMenuObj.SetActive(false);
        async = SceneManager.LoadSceneAsync("main");
        async.allowSceneActivation = false;

        while (async.isDone == false)
        {
            slider.value = async.progress;
            if (async.progress == 0.9f)
            {
                slider.value = 1f;
                async.allowSceneActivation = true;
            }
            yield return null;
        }
    }
}
