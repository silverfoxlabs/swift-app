import OpenAPIClient

extension RecipesInner: RecipeInterface {
    
    func isValid() -> Bool {
        
        guard let name = self.name, !name.isEmpty,
              let cuisine = self.cuisine, !cuisine.isEmpty,
              let photoUrlLarge = self.photoUrlLarge, !photoUrlLarge.isEmpty,
              let photoUrlSmall = self.photoUrlSmall, !photoUrlSmall.isEmpty,
              let sourceUrl = self.sourceUrl, !sourceUrl.isEmpty,
              let uuid = self.uuid, !uuid.isEmpty,
              let youtubeUrl = self.youtubeUrl, !youtubeUrl.isEmpty
        else { return false }
        
        return true
    }
    
}

