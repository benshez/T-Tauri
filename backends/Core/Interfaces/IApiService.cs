namespace Core.Interfaces;

public interface IApiClient<T>
{
    Task<T> GetAsync(string url);
    Task<T> PostAsync(string url, T item);
    Task<T> PutAsync(string url, T item);
    Task DeleteAsync(string url);
}