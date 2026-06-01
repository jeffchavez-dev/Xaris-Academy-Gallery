// Firebase configuration — Xaris Academy
// Using compat SDK (no ES module imports needed for static HTML site)
const firebaseConfig = {
  apiKey:            "AIzaSyBan7JR7mnI4m_FHf6i5k-h_WB8_vucCmc",
  authDomain:        "xaris-academy.firebaseapp.com",
  projectId:         "xaris-academy",
  storageBucket:     "xaris-academy.firebasestorage.app",
  messagingSenderId: "992263672766",
  appId:             "1:992263672766:web:7064430383fd040c705fef",
  measurementId:     "G-SSTY86FWQZ"
};

firebase.initializeApp(firebaseConfig);
const db   = firebase.firestore();
const auth = firebase.auth();
