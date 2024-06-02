import React, {useEffect, useState} from "react";
import {PhotoIcon} from "@heroicons/react/16/solid";
import { toast } from "sonner";

const FileProcessor = ({ type }) => {
  const [fileData, setFileData] = useState("");
  const [dateData, setDateData] = useState("");
  const [disableSubmit, setDisableSubmit] = useState(true);

  useEffect(() => {
    if (typeof fileData.name !== "undefined") {
      setDisableSubmit(false)
    }
  }, [dateData, fileData]);

  const formSubmitter = async (event) => {
    event.preventDefault()

    const formData = new FormData();
    formData.append("file", fileData)
    formData.append("duration", dateData)
    formData.append("type", type)

    await fetch(`/admin/actions`, {
      cache: "no-store",
      method: "POST",
      body: formData,
      headers: { "X-CSRF-Token": "aaa", "Contetnt-Type":"multipart/form-data" }
    })

    toast.success(`File with ${type} was successfully uploaded. In a few minutes you will see result on the draft ${type} page`);
  }

  const handleFile = (files) => {
    const file = files[0];
    setFileData(file)
  }

  return(
    <div className="pl-4 mt-10 flex justify-center">
      <form onSubmit={formSubmitter}>
        <div className="space-y-12">
          <div className="border-b border-gray-900/10 pb-12 ">
            <h1 className="text-base font-bold leading-7 text-gray-900">Upload {type} for processing</h1>
            <p className="mt-1 leading-6 text-gray-600">
              Upload file with {type} for processing and displaying them on WAnswers site.
            </p>

            <div className="flex justify-center">
              <div className="mt-10 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
                <div className="col-span-full">
                  <label htmlFor="country" className="block text-sm font-medium leading-6 text-gray-900 sm:pt-1.5">
                    {type} will be created in selected period:
                  </label>
                  <div className="mt-2 sm:col-span-2 sm:mt-0">
                    <select
                      id="duration"
                      name="duration"
                      autoComplete="duration"
                      className="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:max-w-xs sm:text-sm sm:leading-6"
                      onChange={(event) => setDateData(event.target.value)}
                    >
                      <option value={7}>Since 7 days ago to today</option>
                      <option value={14}>Since 14 days ago to today</option>
                      <option value={30}>Since 30 days ago to today</option>
                      <option value={180}>Since 6 months ago to today</option>
                      <option value={365}>Since 1 year ago to today</option>
                    </select>
                  </div>
                </div>

                <div className="mt-2 sm:col-span-2 sm:mt-0 w-full">
                  <div className="flex max-w-2xl justify-center rounded-lg border border-dashed border-gray-900/25 px-6 py-10">
                    <div className="text-center">
                      <PhotoIcon className="mx-auto h-12 w-12 text-gray-300" aria-hidden="true" />
                      <div className="mt-4 flex text-sm leading-6 text-gray-600">
                        <label
                          htmlFor="file-upload"
                          className="relative cursor-pointer rounded-md bg-white font-semibold text-indigo-600 focus-within:outline-none focus-within:ring-2 focus-within:ring-indigo-600 focus-within:ring-offset-2 hover:text-indigo-500"
                        >
                          <span>Upload a TXT file{" "}</span>
                          <input id="file-upload" name="file-upload" type="file" className="sr-only" onChange={(event) => handleFile(event.target.files)} />
                        </label>
                        <p className="pl-1">{typeof fileData.name !== "undefined" ? `Uploaded file ${fileData.name}` : "or drag and drop"}</p>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>

        <div className="mt-6 flex items-center justify-center gap-x-6">
          <button
            type="submit"
            disabled={disableSubmit}
            className="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
          >
            Process
          </button>
        </div>
      </form>
    </div>
  )
}

export default FileProcessor