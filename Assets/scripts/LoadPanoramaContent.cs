using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LoadPanoramaContent : MonoBehaviour {

	[SerializeField]
	string sceneName;
	[SerializeField]
	bool loadOnAwake = true;

	void Awake()
	{
		if(loadOnAwake)
			LoadContent();
	}
	void LoadContent()
	{
		SceneManager.LoadSceneAsync(sceneName, LoadSceneMode.Additive);
	}

}
