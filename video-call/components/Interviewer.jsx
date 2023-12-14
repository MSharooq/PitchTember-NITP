"use client"
import React, {useState, useEffect, Fragment} from 'react';
import Chatbox from './Chatbox';
import {useRouter} from 'next/router';


const AudioToText = ({user}) => {


    const [listening, setListening] = useState(false);
    const [transcription, setTranscription] = useState('');

    const [prompt, setPrompt] = useState(user.prompts.at(-1).content)

    useEffect(() => {

    }, [prompt]);

    let recognition = null;

    const startListening = () => {
        if (!recognition) {
            recognition = new (window.SpeechRecognition || window.webkitSpeechRecognition)();
            recognition.lang = 'en-US'; // Set the language to your preferred locale.
            recognition.interimResults = true; // Enable interim results.

            recognition.onstart = () => {
                setListening(true);
            };

            recognition.onend = () => {
                setListening(false);
            };

            recognition.onresult = (event) => {
                const result = event.results[event.results.length - 1];
                if (result.isFinal) {
                    const transcript = result[0].transcript;
                    setTranscription((prevTranscription) => prevTranscription + transcript);
                }
            };
        }
        recognition.start();
    };

    const stopListening = () => {
        if (recognition) {
            recognition.stop();
            recognition = null;
            setListening(false);
        }
    };

    const handleNext = async () => {

        let prompt = user.prompts
        prompt.push({
            "role": "user",
            "content": transcription
        })

        const data = {
            id: user._id,
            prompt
        }
        fetch(`http://localhost:5000/api/v1/gpt/check`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
            .then(res => res.json())
            .then(data => {
                if(data.success){
                    console.log(data)
                    setPrompt(data.next)
                    setTranscription('')
                }
            })
            .catch((err) => {
                console.error(err);
            })
    }

    return (
        <div>
            <div>{transcription}</div>
            <Fragment>
                <div className="flex flex-col justify-between">
                    <Chatbox
                        name="Question"
                        content={prompt}
                    />
                    <div className="flex p-5">
                        <button
                            className={`${listening ? 'bg-green-950' : 'bg-green-500'} p-2 px-10 m-1 rounded`}
                            onClick={startListening}
                            disabled={listening}
                        >
                            Start
                        </button>
                        <button
                            className={`${!listening ? 'bg-red-950' : 'bg-red-500'} p-2 px-10 m-1 rounded`}
                            onClick={stopListening}
                            disabled={!listening}
                        >
                            Stop
                        </button>
                        <button
                            className="bg-gray-700 p-2 px-10 m-1 rounded"
                            onClick={handleNext}
                        >
                            Next
                        </button>

                    </div>
                </div>
            </Fragment>
        </div>
    );
};

export default AudioToText;
