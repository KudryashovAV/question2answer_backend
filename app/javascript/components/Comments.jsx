import React, {useEffect, useState} from "react";
import Navbar from "./navBar";
import { FaLongArrowAltDown, FaLongArrowAltUp, FaSearch } from "react-icons/fa";
import {Input} from "@headlessui/react";
import Pagination from "./pagination";

const Comments = () => {
  const [query, setQuery] = useState(null);
  const [page, setPage] = useState(1);
  const [condition, setCondition] = useState("");
  const [responce, setSetResponce] = useState({});
  const [sortOption, setSortOption] = useState("");

  const getResponce = async (page, query, condition, page_type) => { await fetch(
    `/api/admin?query=${query || "undefined"}&page=${page}&condition=${condition}&page_type=${page_type}&sort_by=${sortOption}`,
    {cache: "no-store"},
  ).then(async (response) => { setSetResponce(await response.json()) });
  }

  const deleteQuestions = async (condition, page_type, id = 1) => { await fetch(
    `/api/admin/${id}?condition=${condition}&page_type=${page_type}`,
    {method: "DELETE"},
  ).then(() => { window.location.reload() });
  }

  const publishQuestions = async (type, page_type, id = 1) => { await fetch(
    `/api/admin/${id}?type=${type}&page_type=${page_type}`,
    {method: "PATCH"},
  ).then(() => { window.location.reload() });
  }

  useEffect(() => {
    getResponce(page, query, condition, "comments_page");
  }, [query, page, condition, sortOption]);

  const { comments, total_pages, total_records } = responce
  const isNext = total_records > 12 && page <= total_pages;

  const dateFormatter = (date) => {
    const formattedDate = date.split("T")[0]
    const time = date.split("T")[1]
    const formattedTime =  time.toString().split(".")[0]

    return formattedDate + " at " + formattedTime
  }

  return (
    <div>
      <Navbar />
      <h1 className="text-2xl font-bold ml-6 mt-6">Comments page</h1>

      <>
        <div className="mt-11 flex justify-between gap-5 max-sm:flex-col sm:items-center">
          <div className="flex-1 bg-gray-100 flex items-center rounded-lg px-4 border">
            <label htmlFor="search" className="cursor-pointer text-light-500">
              <FaSearch />
            </label>
            <Input
              type="text"
              id="search"
              placeholder="Search by content..."
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
              className={`${condition === "creation_type:test" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("creation_type:test")}
            >
              Test comments
            </div>
            <div
              className={`${condition === "creation_type:generated" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("creation_type:generated")}
            >
              Generated comments
            </div>
            <div
              className={`${condition === "published:false" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("published:false")}
            >
              Unpublished comments
            </div>
            <div
              className={`${condition === "published:true" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("published:true")}
            >
              Published comments
            </div>
            <div
              className={`${condition === "creation_type:" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("creation_type:")}
            >
              Real comments
            </div>
            <div
              className={`${condition === "" ? "bg-gray-200" : ""} text-indigo-600 text-lg font-bold hover:bg-gray-100 hover:cursor-pointer p-1 border-x border-b`}
              onClick={() => setCondition("")}
            >
              Show all
            </div>
          </div>
        </div>

        <div className="mt-10 flex flex-col">
          {(condition === "creation_type:test" || condition === "") && (<div className="ml-5 mb-1" >Actions:</div>)}
          <div className="ml-5 flex flex-row max-sm:flex-col">
            {(condition === "creation_type:test" || condition === "") && (<button
              className="rounded-md bg-indigo-600 px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
              onClick={() => deleteQuestions("creation_type:test", "user_page")}
            >
              Remove all test comments
            </button>)}
          </div>
        </div>

        <div className="mt-10 flex flex-col">
          <div className="ml-5 mb-1" >Sort by:</div>
          <div className="ml-5 flex flex-row max-sm:flex-col">
            <div className="mx-5 flex flex-row max-sm:flex-col border-x b-b">
              <div
                className={`text-indigo-600 text-lg font-bold p-1`}
              >
                Created at
              </div>
              <div className="ml-1 flex flex-row max-sm:flex-col">
                <button
                  className={`${sortOption === "created_at:desc" ? "bg-orange-600" : "bg-indigo-600"} rounded-md px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600`}
                  onClick={() => setSortOption("created_at:desc")}
                >
                  <FaLongArrowAltDown />
                </button>
              </div>
              <div className="ml-1 flex flex-row max-sm:flex-col">
                <button
                  className={`${sortOption === "created_at:asc" ? "bg-orange-600" : "bg-indigo-600"} rounded-md px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600`}
                  onClick={() => setSortOption("created_at:asc")}
                >
                  <FaLongArrowAltUp />
                </button>
              </div>
            </div>
            <div className="mx-5 flex flex-row max-sm:flex-col border-x b-b">
              <div
                className={`text-indigo-600 text-lg font-bold p-1`}
              >
                Content
              </div>
              <div className="ml-1 flex flex-row max-sm:flex-col">
                <button
                  className={`${sortOption === "content:desc" ? "bg-orange-600" : "bg-indigo-600"} rounded-md px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600`}
                  onClick={() => setSortOption("content:desc")}
                >
                  <FaLongArrowAltDown />
                </button>
              </div>
              <div className="ml-1 flex flex-row max-sm:flex-col">
                <button
                  className={`${sortOption === "content:asc" ? "bg-orange-600" : "bg-indigo-600"} rounded-md px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600`}
                  onClick={() => setSortOption("content:asc")}
                >
                  <FaLongArrowAltUp />
                </button>
              </div>
            </div>
            <div className="mx-5 flex flex-row max-sm:flex-col border-x b-b">
              <div
                className={`text-indigo-600 text-lg font-bold p-1`}
              >
                User name
              </div>
              <div className="ml-1 flex flex-row max-sm:flex-col">
                <button
                  className={`${sortOption === "user_name:desc" ? "bg-orange-600" : "bg-indigo-600"} rounded-md px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600`}
                  onClick={() => setSortOption("user_name:desc")}
                >
                  <FaLongArrowAltDown />
                </button>
              </div>
              <div className="ml-1 flex flex-row max-sm:flex-col">
                <button
                  className={`${sortOption === "user_name:asc" ? "bg-orange-600" : "bg-indigo-600"} rounded-md px-3 py-2 text-sm font-semibold text-white shadow-sm disabled:bg-indigo-200 hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600`}
                  onClick={() => setSortOption("user_name:asc")}
                >
                  <FaLongArrowAltUp />
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="mt-10 flex flex-col gap-5">
          {comments?.length > 0 ? (
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
                          Content
                        </th>
                        <th
                          scope="col"
                          className="sticky top-0 z-10 border-b border-gray-300 bg-white bg-opacity-75 py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter sm:pl-6 lg:pl-8"
                        >
                          Comment author
                        </th>
                        <th
                          scope="col"
                          className="sticky top-0 z-10 border-b border-gray-300 bg-white bg-opacity-75 py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter sm:pl-6 lg:pl-8"
                        >
                          Comment owner
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
                          className="sticky top-0 z-10 border-b border-gray-300 bg-white bg-opacity-75 py-3.5 pl-4 pr-3 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter sm:pl-6 lg:pl-8"
                        >
                          Created at
                        </th>
                        <th
                          scope="col"
                          className="sticky top-0 z-10 hidden border-b border-gray-300 bg-white bg-opacity-75 px-3 py-3.5 text-left text-sm font-semibold text-gray-900 backdrop-blur backdrop-filter sm:table-cell"
                        >
                          Is Reserved
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
                      { comments.map((comment) => (
                        <tr key={comment.id}>
                          <td className="py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                            <p className="w-30">{comment.content}</p>
                          </td>
                          <td className="py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                            <a href={`https://wanswers.com/profile/${comment.user_id}`} className="text-indigo-600 hover:text-indigo-900">
                              {comment.user_name || "Deleted user"}
                            </a>
                          </td>
                          <td className="py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                            {comment.commented_to_type}
                          </td>
                          <td className="py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                            {comment.published?.toString()}
                          </td>
                          <td className="py-4 pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                            {comment.creation_type}
                          </td>
                          <td className="py-4 whitespace-nowrap pl-4 pr-3 text-sm font-medium text-gray-900 sm:pl-6 lg:pl-8">
                            {dateFormatter(comment.created_at)}
                          </td>
                          <td className="hidden px-3 py-4 text-sm text-gray-500 sm:table-cell">
                            {comment.reserved?.toString()}
                          </td>
                          <td className="relative whitespace-nowrap py-4 pr-4 pl-3 text-right text-sm font-medium sm:pr-8 lg:pr-8">
                            <a href={`https://wanswers.com/question/${comment.question_slug}`} className="text-indigo-600 hover:text-indigo-900">
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
            records_type="comments"
            pageHandler={setPage}
          />
        )}
      </>
    </div>
  );
}

export default Comments;
