<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>Update Plan</title>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
  <style>

    #memo {
      height: 200px;
    }

    .btn-custom {
      background-color: #FF9F1C;
      border-color: #FF9F1C;
    }
  </style>
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
<div class="container">
  <h2 class="mb-4">일정 수정</h2>
  <hr>
  <form action="update" method="post">
    <input type="hidden" id="id" name="id" value="${plan.id}" required>
    <div class="mb-3">
      <label for="userId" class="form-label">User ID:</label>
      <input type="text" id="userId" name="userId" value="${plan.userId}" class="form-control" readonly>
    </div>
    <div class="mb-3">
      <label for="title" class="form-label">Title:</label>
      <input type="text" id="title" name="title" value="${plan.title}" class="form-control" required>
    </div>
    <div class="row mb-3">
      <div class="col">
        <label for="startDate" class="form-label">Start Date:</label>
        <input type="date" id="startDate" name="startDate" value="<fmt:formatDate value="${plan.startDate}" pattern="yyyy-MM-dd" type="date"/>" class="form-control" required>
      </div>
      <div class="col">
        <label for="endDate" class="form-label">End Date:</label>
        <input type="date" id="endDate" name="endDate" value="<fmt:formatDate value="${plan.endDate}" pattern="yyyy-MM-dd" type="date"/>" class="form-control" required>
      </div>
    </div>
    <div class="mb-3">
      <label for="memo" class="form-label">Memo:</label>
      <textarea id="memo" name="memo" class="form-control">${plan.memo}</textarea>
    </div>
    <div class="text-center">
      <button type="submit" class="btn btn-custom">수정</button>
      <button type="reset" class="btn btn-custom">재입력</button>
    </div>
  </form>
</div>
</body>
</html>