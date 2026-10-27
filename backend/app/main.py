from fastapi import FastAPI

from app.api.routes import router

app = FastAPI(
    title="Pokémon Deal Hunter API",
    version="0.1.0",
    description="Development API. Market values are sample data unless explicitly sourced.",
)
app.include_router(router, prefix="/api/v1")


@app.get("/health")
def health() -> dict[str, str]:
    return {"status": "ok", "dataMode": "sample"}
