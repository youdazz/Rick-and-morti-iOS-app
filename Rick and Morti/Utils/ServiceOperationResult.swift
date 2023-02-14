//
//  ServiceResult.swift
//  Rick and Morti
//
//  Created by Youchen Zhou on 6/2/23.
//

import Foundation
enum ServiceOperationResult<U>
{
  case Success(result: U)
  case Failure(error: ServiceOperationError)
}


// MARK: - App operation errors

enum ServiceOperationError: Equatable, Error
{
  case CannotFetch(String)
  case CannotCreate(String)
  case CannotDelete(String)
}

func ==(lhs: ServiceOperationError, rhs: ServiceOperationError) -> Bool
{
  switch (lhs, rhs) {
  case (.CannotFetch(let a), .CannotFetch(let b)) where a == b: return true
  case (.CannotCreate(let a), .CannotCreate(let b)) where a == b: return true
  case (.CannotDelete(let a), .CannotDelete(let b)) where a == b: return true
  default: return false
  }
}
