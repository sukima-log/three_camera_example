import * as THREE from 'three';
import { OrbitControls } from 'three/examples/jsm/controls/OrbitControls.js';
import { GLTFLoader } from 'three/examples/jsm/loaders/GLTFLoader.js';

let scene: THREE.Scene;               // シーン定義
let camera: THREE.PerspectiveCamera;  // カメラ定義
let renderer: THREE.WebGLRenderer;    // レンダラー定義
let controls: OrbitControls;          // OrbitControlsを追加

function init() {
  /* シーン作成 */
  scene = new THREE.Scene();
  
  /* カメラ作成 */
  camera = new THREE.PerspectiveCamera(
    45,                                       // 視野
    window.innerWidth / window.innerHeight,   // アスペクト
    0.1,                                      // どの程度のカメラ距離から描画を始めるか
    1000                                      // どのくらい遠くまで見えるか
  );
  scene.add(camera);
  // カメラのポジションと向きを決定
  camera.position.x = -30;
  camera.position.y = 40;
  camera.position.z = 30;
  camera.lookAt(scene.position); // シーンの中心にカメラを向ける
  
  /* レンダラー作成 */
  renderer = new THREE.WebGLRenderer();
  renderer.setClearColor(new THREE.Color(0xeeeeee));
  renderer.setSize(window.innerWidth, window.innerHeight);
  
  /* ライト作成 */
  // 均等光源(影ができない)
  var ambientLight = new THREE.AmbientLight(0x0c0c0c);
  scene.add(ambientLight);
  // 点座標への光源(影ができる)
  var spotLight = new THREE.SpotLight(0xffffff);
  spotLight.position.set(-20, 30, -5);
  spotLight.castShadow = true; // 影を落とす
  scene.add(spotLight);
  // 無限遠からの平行光源
  var directionalLight = new THREE.DirectionalLight(0xffffff, 0.3);
  directionalLight.position.set(20, -30, 5).normalize(); // 光源の方向を設定
  scene.add(directionalLight);

  /* 球体作成 */
  // var sphereGeometry = new THREE.SphereGeometry(9, 20, 20);
  // var sphereMaterial = new THREE.MeshLambertMaterial({ color: 0x1327ff });
  // var sphere = new THREE.Mesh(sphereGeometry, sphereMaterial);
  // // 球体ポジション等
  // sphere.position.x = 0;
  // sphere.position.y = 0;
  // sphere.position.z = 0;
  // sphere.castShadow = true;
  // // オブジェクトをシーンに追加
  // scene.add(sphere);

  // glbファイルの読み込み
  const loader = new GLTFLoader();
  loader.load ('assets/models/vrm/AliciaSolid.vrm', function(gltf){
    // モデルスケール変更
    gltf.scene.scale.set(33, 33, 33);
    gltf.scene.position.set(0, -33, 0);
    gltf.scene.rotation.set(0, (90 * Math.PI /180), 0);
    scene.add(gltf.scene);
  }, undefined, function (error) {
    console.error(error);
  }); 
  
  // レンダラーの出力をhtmlに追加
  const container = document.getElementById("WebGL-output");
  if (container) {
    container.appendChild(renderer.domElement);
  }

  // OrbitControlsを初期化、カメラとレンダラーを渡す
  controls = new OrbitControls(camera, renderer.domElement);
  controls.enableRotate = true; // カメラの回転を有効にする

  // シーンを描画
  render();
}

// シーンを描画
function render() {
  // レンダリング(再帰)
  requestAnimationFrame(render);
  // 表示
  renderer.render(scene, camera);
}

// 表示領域をウィンドウサイズに合わせる
function onResize() {
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();
  renderer.setSize(window.innerWidth, window.innerHeight);
}

// 表示が終わってからThree.js関連処理(関数init)を実行
window.addEventListener("load", init);

// リサイズイベント
window.addEventListener("resize", onResize, false);
