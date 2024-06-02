import React, {useEffect, useState} from "react";
import Navbar from "./navBar";
import { FaSearch } from "react-icons/fa";
import {Input} from "@headlessui/react";
import Pagination from "./pagination";

const Questions = () => {
  const [query, setQuery] = useState(null);
  const [page, setPage] = useState(1);
  const [condition, setCondition] = useState("undefined");
  const [responce, setSetResponce] = useState({});

  const getResponce = async (page, query, condition) => { await fetch(
    `/api/questions?query=${query || "undefined"}&page=${page}&condition=${condition}`,
    {cache: "no-store"},
    ).then(async (response) => { setSetResponce(await response.json()) });
  }

  const deleteQuestions = async (condition, id = 1) => { await fetch(
    `/api/questions/${id}?condition=${condition}`,
    {method: "DELETE"},
  ).then(() => { window.location.reload() });
  }

  useEffect(() => {
    getResponce(page, query, condition);
  }, [query, page, condition]);

  const { questions, total_pages, total_records } = responce
  const isNext = total_records > 12 && page <= total_pages;

  return (
    <div>
      <Navbar />
      <h1 className="text-2xl font-bold ml-6 mt-6">Questions page</h1>

      <>
        <div className="mt-11 flex justify-between gap-5 max-sm:flex-col sm:items-center">
          <div className="flex-1 bg-gray-100 flex items-center rounded-lg px-4 border">
            <label htmlFor="search" className="cursor-pointer text-light-500">
              <FaSearch />
            </label>
            <Input
              type="text"
              id="search"
              placeholder="Search by title..."
              value={query || ""}
              className="w-full border-none bg-gray-100 focus-visible:ring-0 focus-visible:ring-offset-0"
              onChange={(e) => setQuery(e.target.value)}
            />
          </div>
        </div>

        <div className="mt-10 flex flex-col">
          <div className="ml-5 mb-1" >Filters:</div>
          <div className="ml-5 flex flex-row max-sm:flex-col">
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("creation_type:test")}
            >
              Test questions
            </div>
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("creation_type:generated")}
            >
              Generated questions
            </div>
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("published:false")}
            >
              Unpublished questions
            </div>
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("published:true")}
            >
              Published questions
            </div>
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("creation_type:")}
            >
              Real questions
            </div>
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => setCondition("")}
            >
              Show all
            </div>
          </div>
        </div>

        <div className="mt-10 flex flex-col">
          <div className="ml-5 mb-1" >Actions:</div>
          <div className="ml-5 flex flex-row max-sm:flex-col">
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
              onClick={() => deleteQuestions("creation_type:test")}
            >
              Remove all test questions
            </div>
            <div
              className="text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b"
            >
              Publish questions
            </div>
          </div>
        </div>

        <div className="mt-10 flex flex-col gap-5">
          {questions?.length > 0 ? (
              <div className="px-4 sm:px-6 lg:px-8">
                <div className="mt-8 flow-root">
                  <div className="-mx-4 -my-2 sm:-mx-6 lg:-mx-8">
                    <div className="inline-block min-w-full py-2 align-middle">
                      <table className="min-w-full border-separate border-spacing-0">
                        <thead>
                        <tr>
                          <th
                            scope="col"
                            className="sticky top-0 z-10 border-b border-gray-300 bg-white bg-opacity-75 py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter sm:pl-6 lg:pl-8"
                          >
                            Title
                          </th>
                          <th
                            scope="col"
                            className="sticky top-0 z-10 border-b border-gray-300 bg-white bg-opacity-75 py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter sm:pl-6 lg:pl-8"
                          >
                            Published
                          </th>
                          <th
                            scope="col"
                            className="sticky top-0 z-10 border-b border-gray-300 bg-white bg-opacity-75 py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter sm:pl-6 lg:pl-8"
                          >
                            Creation type
                          </th>
                          <th
                            scope="col"
                            className="sticky top-0 z-10 hidden border-b border-gray-300 bg-white bg-opacity-75 px-3 py-3.5 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter sm:table-cell"
                          >
                            Author
                          </th>
                          <th
                            scope="col"
                            className="sticky top-0 z-10 hidden border-b border-gray-300 bg-white bg-opacity-75 px-3 py-3.5 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter lg:table-cell"
                          >
                            Answers count
                          </th>
                          <th
                            scope="col"
                            className="sticky top-0 z-10 hidden border-b border-gray-300 bg-white bg-opacity-75 px-3 py-3.5 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter lg:table-cell"
                          >
                            Comments count
                          </th>
                          <th
                            scope="col"
                            className="sticky top-0 z-10 border-b border-gray-300 bg-white bg-opacity-75 py-3.5 pl-3 pr-4 backdrop-blur backdrop-filter sm:pr-6 lg:pr-8"
                          >
                            <span className="sr-only">Show</span>
                          </th>
                        </tr>
                        </thead>
                        <tbody>
                        { questions.map((question) => (
                          <tr key={question.id}>
                            <td className="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                              {question.title}
                            </td>
                            <td className="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                              {question.published.toString()}
                            </td>
                            <td className="whitespace-nowrap py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                              {question.creation_type}
                            </td>
                            <td className="whitespace-nowrap hidden px-3 py-4 text-sm text-gray-500 sm:table-cell">
                              {question.user_name || "User NAME"}
                            </td>
                            <td className="whitespace-nowrap hidden px-3 py-4 text-sm text-gray-500 lg:table-cell">
                              {question.answers_count}
                            </td>
                            <td className="whitespace-nowrap hidden px-3 py-4 text-sm text-gray-500 lg:table-cell">
                              {question.comments_count}
                            </td>
                            <td className="relative whitespace-nowrap py-4 pr-4 pl-3 text-right text-sm font-medium sm:pr-8 lg:pr-8">
                              <a href="#" className="text-indigo-600 hover:text-indigo-900">
                                {"Show >>"}
                              </a>
                            </td>
                          </tr>
                        ))}
                        </tbody>
                      </table>
                    </div>
                  </div>
                </div>
              </div>
          ) : (<h1>Nothing to show</h1>)}
        </div>
        {isNext && (
          <Pagination
            pageNumber={page || 1}
            isNext={isNext}
            total_pages={total_pages}
            total_records={total_records}
            records_type="questions"
            pageHandler={setPage}
          />
        )}
      </>
    </div>
  );
}

export default Questions;
